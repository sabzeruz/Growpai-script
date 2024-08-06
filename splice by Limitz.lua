--Script by Limitz#4889
--update some of the scripts by krenze

SeedA = 455 --First Seed
SeedB = 1105 -- Second Seed

SeedAP = 455 --dialog number
SeedBP = 1105 --dialog number

Delay = 400 --Delay

function hook(varlist)
    if varlist[0]:find("OnDialogRequest") and (varlist[1]:find("Item Finder")) then
        return true
    end
end
AddCallback("Detect", "OnVarlist", hook)


local function p(x, y,id)
  local player = GetLocal()
  local pkt_punch = {
    type = 3,
    int_data = id,
    pos_x = player.pos_x,
    pos_y = player.pos_y,
    int_x = x,
    int_y = y,
  }
  SendPacketRaw(pkt_punch)
end

function count(id)
    local c = 0
    for _, inv in pairs(GetInventory()) do
    if inv.id == id then
    c = c + inv.count
    end
    end
    return c
    end

while true do
    for x = 0, 199 do
    for y = 0, 199 do
        T,T2 = GetTile(x,y),GetTile(x,y+1)
        if T2.fg ~= 0 then
            if T.fg == 0 then
                FindPath(x,y)
                Sleep(50)
                p(x,y,SeedA)
                Sleep(Delay)
                p(x,y,SeedB)
                Sleep(Delay)
                if count(455) < 1 then
                SendPacket(2, "action|dialog_return\ndialog_name|item_search\n455|1")
                Sleep(1000)
                FindPath(x,y)
                Sleep(50)
                p(x,y,SeedB)
                Sleep(Delay)
                if count(1105) < 1 then
                    SendPacket(2, "action|dialog_return\ndialog_name|item_search\n1105|1")
                    Sleep(1000)
                end
                FindPath(x,y)
                Sleep(50)
                p(x,y,SeedA)
                Sleep(Delay)
            else
                -- Nothing
            end
        end
    end
    end
end
end
