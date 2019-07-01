Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06747246E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2019 06:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfEUEd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 May 2019 00:33:27 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:46933 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfEUEd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:33:26 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1168068D;
        Tue, 21 May 2019 00:33:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 21 May 2019 00:33:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        AlWrfBTrcpPv2MHnZ7Kz+KHi+IVsVLeNo9zFDUGz76Y=; b=n4hFcBI7t383uVyf
        rn6SAFOdBocVIvP2WYVx9mCubIyxB52Fsxt6YEBCpVuomjIZbvKpXxwtm2jigzHG
        7hoJmQm8fzT37fif6X/aKk9Bb/VZxaNn6tBoCqPfE3WV2GCpLQE/R3ULig/iHe7a
        SYZMEDuEqGoW4SYYOQKVA4f+nv+mdUc7l8NnHwES6OOeYkAwChvON11E2+pVmBIe
        rP1oGN5lqS9Ge5kpJtoPDN6I4IUABmdYRLgBy+v3Ek6/g7MpkEU+1uza35hgzWpn
        oaTX60NkF1VAO5nL8YYlaAeQwjWue0WobbecPq9wKHB1KPFRyMbsJtAT9BOmtHvA
        HQ4HOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=AlWrfBTrcpPv2MHnZ7Kz+KHi+IVsVLeNo9zFDUGz7
        6Y=; b=Ppy3lDs/uAXuwh6Bfhz2pMFRedUu6AdzAc+Uyn2tBzLL0/wIYhLd8WshG
        FyjdQNKYqsei7uqFdcRNYOpeRwQ6MICh/qM/27gS+YCp2u8do03efOrZuPjC1vDV
        F2ebVYbGrlAvTkUsNIS5ry9wS0TKtPl3YDN90xGOeMNbGyfKunBIqYWnrhRDhZln
        LizlfsSpbRZCCX9Ygl9gaIBJlqa/1OxJ634FMy08YdgyZY2t9LkvHuvwDiXqV1nL
        5rgYYP0jYKoSL21ZvvholK+xDdDoWXTlQxv7Dg3Qgs50bA39Cc3gizTEJwpLsX69
        Bd/1BgzEezuG7WfqLsuDe0pRu+sKQ==
X-ME-Sender: <xms:k3_jXDg75Llg6VcPCl5wWvcnNSHfaYWJN5wYY_8z4eSQeZMwsw583A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefkuffhvfffjghftggfggfgsehtjeertddt
    reejnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgvhicuoehruhhstghurhesrhhush
    hsvghllhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddv
    rdelledrkedvrddutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruh
    hsshgvlhhlrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:k3_jXEkafT24d5MddrYm-5I2xa8VYHejmOeUC9W7NnP4fQFvTTyXfA>
    <xmx:k3_jXANHDl4rw_mFtE2sgFaPs8Wkl9LqweSfOSFwayKMcC6INLjTrw>
    <xmx:k3_jXHF_YDP0pcKsWRH0_D_ld2mg37PygOwtC2W9q9_kBzaHv7XOXw>
    <xmx:lH_jXBd6lIprkHfLs2QimfROtqsr62W8b2oHghmEtxyugbpnrIzEvg>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id A7D778005B;
        Tue, 21 May 2019 00:33:20 -0400 (EDT)
Message-ID: <6a90db30c8543d547ab8543fbdba02f7fe6a4898.camel@russell.cc>
Subject: Re: [RFC PATCH] powerpc/mm: Implement STRICT_MODULE_RWX
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 21 May 2019 14:33:17 +1000
In-Reply-To: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
References: <df502ffe07caa38c46b0144fc824fff447f4105b.1557901092.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 06:20 +0000, Christophe Leroy wrote:

Confirming this works on hash and radix book3s64.

> +
> +	// only operate on VM areas for now
> +	area = find_vm_area((void *)addr);
> +	if (!area || end > (unsigned long)area->addr + area->size ||
> +	    !(area->flags & VM_ALLOC))
> +		return -EINVAL;

https://lore.kernel.org/patchwork/project/lkml/list/?series=391470

With this patch, the above series causes crashes on (at least) Hash,
since it adds another user of change_page_rw() and change_page_nx()
that for reasons I don't understand yet, we can't handle.  I can work
around this with:

	if (area->flags & VM_FLUSH_RESET_PERMS)
		return 0;

so this is broken on at least one platform as of 5.2-rc1.  We're going
to look into this more to see if there's anything else we have to do as
a result of this series before the next merge window, or if just
working around it like this is good enough.

- Russell

