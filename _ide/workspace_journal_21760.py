# 2026-03-07T10:01:34.896107400
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.get_component(name="equalStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

