// Copyright (c) 2022 UltiMaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.7
import QtQuick.Layouts 1.3

import UM 1.5 as UM
import Cura 1.7 as Cura


RecommendedSettingSection
{
    id: enableAdhesionRow

    title: catalog.i18nc("@label", "Adhesion")
    icon: UM.Theme.getIcon("Adhesion")
    enableSectionSwitchVisible: platformAdhesionType.properties.enabled == "True"
    enableSectionSwitchChecked: platformAdhesionType.properties.value != "skirt" && platformAdhesionType.properties.value != "none"
    enableSectionSwitchEnabled: recommendedPrintSetup.settingsEnabled
    tooltipText: catalog.i18nc("@label", "Enable printing a brim or raft. This will add a flat area around or under your object which is easy to cut off afterwards.")

    property var curaRecommendedMode: Cura.RecommendedMode {}

    property UM.SettingPropertyProvider platformAdhesionType: UM.SettingPropertyProvider
    {
        containerStack: Cura.MachineManager.activeMachine
        removeUnusedValue: false //Doesn't work with settings that are resolved.
        key: "adhesion_type"
        watchedProperties: [ "value", "resolve", "enabled" ]
        storeIndex: 0
    }

    function onEnableSectionChanged(state) {
        curaRecommendedMode.setAdhesion(state)
    }

    contents: [
        RecommendedSettingItem
        {
            isCompressed: enableAdhesionRow.isCompressed
            settingName: catalog.i18nc("@action:label", "Print with")
            tooltipText: catalog.i18nc("adhesion_extruder_nr description", "The extruder train to use for printing the skirt/brim/raft. This is used in multi-extrusion.")

            settingControl: Cura.SingleSettingExtruderSelectorBar
            {
                extruderSettingName: "adhesion_extruder_nr"
            }
        }
    ]
}
