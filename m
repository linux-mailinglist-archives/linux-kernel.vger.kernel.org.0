Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DC1352F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jan 2020 07:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgAIGAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 01:00:42 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54557 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgAIGAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 01:00:41 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C1C9D21F18;
        Thu,  9 Jan 2020 01:00:40 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 01:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Ynx/sG4Nu6QytMUoZxOmN9kX3FtDIxE
        I42xzek+Pfn0=; b=TUpA+YSTG1tGmezaZ9Ah0mNl6rxp8Ybki5q4KLihafGSdz0
        GuUuOlEF2247hWUPdze9hMGZUycaksL6VTUnk60pXHIg8sd1kjpGCZGEKRF7J26e
        mfvLZggOTBI9ZGZ6IFZRgapabYwzExHTREuyZcjX2CThxc++T/ojrlJ+rApjKuOx
        9v3kKerGLy18L5clOgZa6b4c7/GfBE3/K1Tz2Z62e7XlcTTx57tKjMoiOGv4WV6R
        dv2ed5WCpA9FI8UDmsr1JzUNEKRXM4PvOP0LO9CTpaitVjchwdglCcI5pP3jvv3O
        NqMyu5lx8UBU+fnx3vKuXe68Natiwn0CWPgYPwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ynx/sG
        4Nu6QytMUoZxOmN9kX3FtDIxEI42xzek+Pfn0=; b=pYgh4MG+6v0x/kOzN58ZwD
        0bVlCg+bvMKnJ7HSV3dTsd9CepSbqqD5giIeoZZBaMHx2Mv7SIlLoFgtfv7QRU3e
        HLQ3OGZgtuvSwfOfJheVMQAPDMBa3SHtG+2etnMBnwkufyrXUHUkTqNZsO5uOrvn
        lqhg3exfvjV6CfiAzG7CJYSpOiWB1LNlHzMxhTVmjxUgCFNupoMt0PxkOEuJ8HdC
        5cEK6tPNWZZaUbaeYEXO2Y+nIBjMaCiTgLPzvv/5WhO/aGea8epxvvbH6hNItUdI
        OfihBIct4QIZc2uDsakv2heOp9LBoP8A4JPTVnxuJt35cnHF4ZWoklN4zrWY3EaQ
        ==
X-ME-Sender: <xms:iMEWXie_pANBnkpVJ4G9iIWhVSn1ALKEyq2jE_ZuYKEhu8L-MVBvAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgepvd
X-ME-Proxy: <xmx:iMEWXk8EVHkyetfY_EsZL1wQLhQeBQjFOptSNMGyVAYBpqZGWhbCSg>
    <xmx:iMEWXo_Qww5xAHrrrDWUtFRccjch_zScy46gp45C_EOn9GUp_8ndbw>
    <xmx:iMEWXjrPfJjDS8JJfVAUBmuo6aJzHGu1cPnOfhZ-hZMxZIkhXMgESg>
    <xmx:iMEWXu4fJaFzyS2ddFpjcI0zT-HJL02VY4DSGpXxjYd0z_OfiycH_g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D45EE00A5; Thu,  9 Jan 2020 01:00:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <581ff3b5-c6c1-4e29-b87c-3bd961c4e659@www.fastmail.com>
In-Reply-To: <1577993276-2184-11-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-11-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 16:32:40 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 10/12] ARM: dts: aspeed: ast2600: Add XDMA Engine
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> Add a node for the XDMA engine with all the necessary information.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
