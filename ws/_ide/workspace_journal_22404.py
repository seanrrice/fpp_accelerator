# 2026-05-11T15:53:55.508572700
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="SYNTHESIS")

comp.run(operation="PACKAGE")

comp.run(operation="IMPLEMENTATION")

vitis.dispose()

vitis.dispose()

