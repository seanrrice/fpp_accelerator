# 2026-03-07T10:33:27.546243600
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

client.delete_component(name="equalStep_baseline")

client.delete_component(name="componentName")

vitis.dispose()

