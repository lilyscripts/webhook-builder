--[[

made by lilyscripts
https://discord.gg/S4NHgEVmxy

]]

--// Initializing Variables
local httpService = game:GetService("HttpService")
local request = request or http_request or http.request

--// Webhook Builder
local function webhookBuilder(webhookUrl)
    local webhook = {}

    webhook.webhookUrl = webhookUrl
    webhook.username = nil
    webhook.avatarUrl = nil
    webhook.content = nil
    webhook.embeds = {}

    function webhook:setUsername(username)
        webhook.username = username
    end

    function webhook:setAvatarUrl(avatarUrl)
        webhook.avatarUrl = avatarUrl
    end

    function webhook:setContent(content)
        webhook.content = content
    end

    function webhook:createEmbed()
        local embed = {}
        
        function embed:setAuthor(name, url, iconUrl)
            embed.author = {
                name = name,
                url = url or nil,
                icon_url = iconUrl or nil
            }
        end

        function embed:setTitle(title)
            embed.title = title
        end

        function embed:setUrl(url)
            embed.url = url
        end

        function embed:setDescription(description)
            embed.description = description
        end

        function embed:setColor(color)
            embed.color = color
        end

        function embed:addField(name, value, inline)
            embed.fields = embed.fields or {}
            table.insert(embed.fields, {
                name = name,
                value = value,
                inline = inline or false
            })
        end

        function embed:setThumbnail(url)
            embed.thumbnail = {
                url = url
            }
        end

        function embed:setImage(url)
            embed.image = {
                url = url
            }
        end

        function embed:setFooter(text, iconUrl)
            embed.footer = {
                text = text,
                icon_url = iconUrl or nil
            }
        end

        table.insert(webhook.embeds, embed)

        return embed
    end

    function webhook:send()
        request({
            Url = webhook.webhookUrl,
            Method = "POST",
            Body = httpService:JSONEncode({
                username = webhook.username,
                avatar_url = webhook.avatarUrl,
                content = webhook.content,
                embeds = webhook.embeds
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
    end

    return webhook
end

return webhookBuilder
