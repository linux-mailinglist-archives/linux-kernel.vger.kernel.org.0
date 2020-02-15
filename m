Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95B15FC81
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2020 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBODsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Feb 2020 22:48:51 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:41249 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727641AbgBODsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:48:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C55416396;
        Fri, 14 Feb 2020 22:48:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Feb 2020 22:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:from:to:cc:references:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=J
        xzxZHoHqh9JAZUmlnUp3T1XUGzczXINp71ra3TW7JQ=; b=R4/8wFBpD+nDC+YjC
        eYLSKaCjp29dWLWSDaJZh0VjadXi5EWyZIY479EkNhwuSNvqap2F1EXCybrJjgk/
        O6MKTjbBl2XE1zG/SCiLZkZPA5ry0yUx4u5fw2FlAg41FZpng+n49WYyBDpiIgt2
        ecDaHVR0tTou6qWZK5N0SW+/hwaqZNwo4SQ3LDO2FVndXukipXTkpPRrmyli9JD+
        hJmUNEbyZ1CVxDr4IGoxIpGcbliDItQbKy1aU63Z/92JoGztq1QXfPWpVnprv0jB
        YLctjWcWnC9Y9ZHJ74rRtkgOa/QntA5N3iOaLh9/y8N/aCkjbKMIkDL2LGo2MKlK
        WH/dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=JxzxZHoHqh9JAZUmlnUp3T1XUGzczXINp71ra3TW7
        JQ=; b=1TYIQcLwttyQOP1qL5xcxdmc2ZhEDWAqm4O9SDW+3wLAdJJOave8EBEUV
        wiRCTBY1gZJ1eCfSY3xoQzWxbmudFZZ9VBfzRxxUtlhMO6hg+yaNsKk4b7nwWZuG
        uxWRuqXLqnt6B1ZmzZ9Px+s1OL5wkugyV6W5R03T1R4pXr0CjHDwNOjFzY/yQrf9
        vhbJeyAy2X/YJY6qp3qOQalgSZs77EJ5Um84zvE7q0v1tXzUGiIWGep9sbjtfeZh
        PAAE1iNEQkjC/NpwIO22ixvhBiRhKoVAf7GwUqajJlBetMBTttWsxpUvvySfmp3+
        UdaNrgEJAAi/SoKe7xthm+vawX1LQ==
X-ME-Sender: <xms:IGpHXlC662lbobdSX5lT8RYxgwcV6nDTZ_OdHqMsk2JiUojnKqLBLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuhffvfhfkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:IGpHXmXfQpCcFp2tXWIYLvQjSAl4UOQko9gbBJcT5PqOH1Nd9XBTDg>
    <xmx:IGpHXjXlvEm2lFzkQcoqgw6ksUiXRfMELivgTUl-S6U35bnJy2lEvQ>
    <xmx:IGpHXjRl_IunXeo2iNwV2z4wtNnaJ3BnyhpMeXUra2tEa6HUDUr1LA>
    <xmx:IWpHXnGB3y4I3ezWRgNh9I_NJ350WXQ_qrec4gZXpA2B3Z8GDykHxA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B2803060BD1;
        Fri, 14 Feb 2020 22:48:47 -0500 (EST)
Subject: Re: [PATCH v6 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
References: <20200113051852.15996-1-samuel@sholland.org>
 <20200113051852.15996-3-samuel@sholland.org>
 <CABb+yY2MJ-1i0K7XVkPT3+6ac1XR9-3zf-GDNeswOMp6Zn_Ufw@mail.gmail.com>
 <72dc2074-c06d-4bdf-ca5f-b4007f492407@sholland.org>
Message-ID: <89168ba0-a8ac-b433-3f93-412b22a9bc1a@sholland.org>
Date:   Fri, 14 Feb 2020 21:48:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <72dc2074-c06d-4bdf-ca5f-b4007f492407@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 8:18 PM, Samuel Holland wrote:
> Jassi,
> 
> On 2/12/20 8:02 PM, Jassi Brar wrote:
>> On Sun, Jan 12, 2020 at 11:18 PM Samuel Holland <samuel@sholland.org> wrote:
>>>
>>> +static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
>>> +{
>>> +       struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
>>> +       int n = channel_number(chan);
>>> +       uint32_t msg = *(uint32_t *)data;
>>> +
>>> +       /* Using a channel backwards gets the hardware into a bad state. */
>>> +       if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
>>> +               return 0;
>>> +
>>> +       /* We cannot post a new message if the FIFO is full. */
>>> +       if (readl(mbox->regs + FIFO_STAT_REG(n)) & FIFO_STAT_MASK) {
>>> +               mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
>>> +               return -EBUSY;
>>> +       }
>>> +
>> This check should go into sun6i_msgbox_last_tx_done().
>> send_data() assumes all is clear to send next packet.
> 
> sun6i_msgbox_last_tx_done() already checks that the FIFO is completely empty (as
> the big comment explains). So this error could only be hit in the knows_txdone
> == true case, if the client pipelines multiple messages by calling
> mbox_client_txdone() before the message is actually removed from the FIFO.
> 
> From the comments in mailbox_controller.h, this kind of usage looks to be
> unsupported. In that case, I could remove the check entirely. Does that sound right?

After more thought, I would prefer to keep the check. It is fast/simple, and it
keeps the hardware from getting into an inconsistent state. Silently dropping
messages sounds like a poor quality of implementation.

send_data() is documented in mailbox_controller.h as returning EBUSY, and I see
multiple other mailbox controllers implementing the same or a similar check. If
that is not the way you intend for the API to work, then please update the
comments in mailbox_controller.h.

Thanks,
Samuel

>> .....
>>> +
>>> +       mbox->controller.dev           = dev;
>>> +       mbox->controller.ops           = &sun6i_msgbox_chan_ops;
>>> +       mbox->controller.chans         = chans;
>>> +       mbox->controller.num_chans     = NUM_CHANS;
>>> +       mbox->controller.txdone_irq    = false;
>>> +       mbox->controller.txdone_poll   = true;
>>> +       mbox->controller.txpoll_period = 5;
>>> +
>> nit:  just a single space should do too.
>>
>> Sorry, for some reason I thought I had replied to this patch, but
>> apparently not. My mistake. Do you want to revise this submission or
>> send another patch on top?
> 
> For just this change, it would be simpler to send a follow-up patch.
> 
>> thanks
> 
> Thank you,
> Samuel
> 

