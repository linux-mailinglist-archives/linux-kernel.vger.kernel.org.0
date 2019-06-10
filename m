Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB43A3AED6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2019 08:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfFJGAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jun 2019 02:00:52 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:56463 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387702AbfFJGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 02:00:51 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Jun 2019 02:00:51 EDT
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id A25F753B;
        Mon, 10 Jun 2019 01:53:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Jun 2019 01:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=73FhgraWVSKzZSRxr/hRTV6FPo7
        e3zeeTj9HLIcXJQk=; b=WUqIHic7WiL1tl6Nzsn4mc6zoGABOQ4wN1sSg+/DfpX
        eDR9LyWtAtAK7bmMv/djfvbd/hxQYLSyPTFiCJkSs7pwDA+k0zuHVPMzJFJSgHw3
        /fxWavwxOH3ScjpJAJcV7enQ5mGX6eyxmbH1KHNrqvNU+GGf0HAk9BC/3UZIthby
        L3w32R3fMKTTMA3CAt9oGM/50vrm7/R8XdtMg7+h5yRoA1DVwP7da0vwbZ3fgpVj
        w6dw19Dx/eXaZLNh+dzO4XULbgjKZnLoNEGvzcvkXyiMerr3w9jFAF6nBmjVFpDL
        hYNE1f6sH3iWw4pOsFv54YefTGgSGxYs09yyI9ca+/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=73Fhgr
        aWVSKzZSRxr/hRTV6FPo7e3zeeTj9HLIcXJQk=; b=tM2nXGqRR33HPPT5EI0HZc
        F2cn6be9K0q2Zjy4ZtdN/jZyWSurdUkeJm28RoaoW1Y7aG4bNc1BgfPxhwZQhTWr
        a3pP3gra77bTM4OOXH/lvsM8CEH9Uh3MRhb/+qyySxJ1w6emC8GCFxCZfmppaltT
        PPpPBOvA3cbnw4RRrX9q62YiHf8w7lkQy2mpVZTQ1w6gLBprtnMRAeSuOX+m3ENw
        AO/pfg62LPJp45hErJg78UgXMpKF3JZ2UI12n6BHLYlbw1TtwhXDezjHa+BuShqe
        E6DWRzzPyaz9t1iITcWvgf0ut9YGi4P12WFgePoV0N+42zSWfKHzdTuWikXUC42w
        ==
X-ME-Sender: <xms:Y_D9XCL4I63YDmymPGTmvFniACribIhS_R6G5-uDS-stD5U9uiud2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecukfhppeekfedrkeeirdekledruddtjeenucfrrghrrghmpehmrghilhhf
    rhhomhepghhrvghgsehkrhhorghhrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:Y_D9XOYnvOUd54PI8pGbhMxykVnXYJoVVA1jQDiGLi5bu_LxxAdbFQ>
    <xmx:Y_D9XNuNqNrVA0By10jYs1YGzm7VKi_8-jFV6QrdieaPayeCbkjS0Q>
    <xmx:Y_D9XLsxGkhl8c6f5z_dsQOPItDQrZTLeRVHXYq0k2JG537PpwG_nA>
    <xmx:ZPD9XFjGPjsUFuN9HmlXy1yi4HeYj3ADgjRU_n7EbK-YkbPp0OVaLICzGg4>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id B6E34380073;
        Mon, 10 Jun 2019 01:53:38 -0400 (EDT)
Date:   Mon, 10 Jun 2019 07:53:37 +0200
From:   Greg KH <greg@kroah.com>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Dehui Sun <dehui.sun@mediatek.com>
Subject: Re: [PATCH v2] clk: mediatek: mt8183: Register 13MHz clock earlier
 for clocksource
Message-ID: <20190610055337.GB13825@kroah.com>
References: <1560132969-1960-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560132969-1960-1-git-send-email-weiyi.lu@mediatek.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:16:09AM +0800, Weiyi Lu wrote:
> The 13MHz clock should be registered before clocksource driver is
> initialized. Use CLK_OF_DECLARE_DRIVER() to guarantee.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/clk/mediatek/clk-mt8183.c | 46 +++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 12 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
