Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274B713510B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 02:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgAIBvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jan 2020 20:51:37 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35225 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726913AbgAIBvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 20:51:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AE5D99B3;
        Wed,  8 Jan 2020 20:51:35 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 08 Jan 2020 20:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm1; bh=INrQczsxRVeplZbqXtrfLCVklXpA8YI
        m9Wl7iloiOdU=; b=HhawAe0dt3VweQT6qHrXNP1ZSkPljYrSelvC7ilR4GMUb3a
        jgAxXhZB3mQ5RU36n0gAomx55Pou5sBdrhZ21jvxvnnrVefWcRP2FnphsTsIb9tO
        g1QYz3TkyH4NX/nFItjlMv6eRKkubAvnYfXhE1H3kxXx+HBofgA/Hk4M/FS0pyeg
        XB8Hfjif9rtxh7bTVBGntvhwNEhSay6JKHo0fvK2YVCW7hUjnn55C9ygNhgNh4wp
        zhUNat1wi1usZqPOWRN6Mb5WyTbrAQGaofT47XdLldaL2EdQP7HRnFz3TH9vdQDt
        YYHtMzzMeFfKm/PLRKNj6ZIYnyttuSQmc2trlJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=INrQcz
        sxRVeplZbqXtrfLCVklXpA8YIm9Wl7iloiOdU=; b=NPkzPNo3vXx0BFVsVInI9b
        ZrJ8p4t1Bad6m+l4Il0iH6JrHJjYBE4X3RbswTWgD8FMBoHm0lTaOCIPdB93a16s
        kDIor4EMVpRi2pfT5Ckl4QzxwT6fYW7ndZBbdrriY5BPfUjvlq/WiIbtuPVeu0w1
        B769QYtTXCicO6hOT1jhHgV7QgMkzp0Y7y6txomyRIjOtHGxQSDZPTWnxAnVvWPr
        b+nMt95+XJK+ymtOEBNVDdf8UY5s6E0as860cHOMFwLkWNu8ydUGFr2/6GaGLLWy
        kHrH1ddHkwyKQ5QcxDPkZNsf12RzphBCDa4FiknEFNb5l50Wfp3MUGsoPexJwz0A
        ==
X-ME-Sender: <xms:JocWXux7bDeAvG3jS9Bh2t_9UUjKfMOvuUv5qNmmuhV5rUU92i0wFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:JocWXnzDiMIeKUQfypNqgS8HaCY-IizfGQayAcN83yjccJiD2es4_A>
    <xmx:JocWXmpkGcAWz6FSIs_5wuSDbmN8ktpyEY1zrH6HnpdKKtV289JV8A>
    <xmx:JocWXrokrz_BkKts3uJpuIak45JS92JBZRoBft8gpECbZH76_FRi-Q>
    <xmx:J4cWXjh2ymWQgJd1bgMz_VkV0kbeWE4v1-5q8bNS6PYD_VHQXRnAWQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 12408E00A2; Wed,  8 Jan 2020 20:51:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-731-g1812a7f-fmstable-20200106v2
Mime-Version: 1.0
Message-Id: <f93bd92d-e509-4825-a4bf-00f5b7c6ff7d@www.fastmail.com>
In-Reply-To: <20191228190631.26777-1-tiny.windzz@gmail.com>
References: <20191228190631.26777-1-tiny.windzz@gmail.com>
Date:   Thu, 09 Jan 2020 12:23:32 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Yangtao Li" <tiny.windzz@gmail.com>,
        "Jeremy Kerr" <jk@ozlabs.org>, "Joel Stanley" <joel@jms.id.au>,
        "Alistair Popple" <alistair@popple.id.au>,
        "Eddie James" <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsi: aspeed: convert to devm_platform_ioremap_resource
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Dec 2019, at 05:36, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
