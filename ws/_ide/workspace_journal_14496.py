# 2026-05-11T15:22:04.073049300
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp.run(operation="PACKAGE")

comp.run(operation="PACKAGE")

comp.run(operation="IMPLEMENTATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="PACKAGE")

vitis.dispose()

