Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA11E9D0F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2019 15:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfHZNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Aug 2019 09:46:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35260 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbfHZNqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:46:00 -0400
Received: from zn.tnic (p200300EC2F065700581748F40A194E01.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5700:5817:48f4:a19:4e01])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D73D41EC06E5;
        Mon, 26 Aug 2019 15:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566827159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lgs2L33oPizjEeeKNyH9/KUqXdBMNE9/ly1C3kW/Vak=;
        b=n1fDxlrw1KX43iWYmv9XDDWpsDK3N+sX5Xcw8tmQEtcngWfO5I0d2oNFq4YMelGFZSwE8f
        LJWI8JxQ9krSctlFt5IyG6nbfEXjTG2UFU0+vaTLt536/U2VwddBoGq0p+75JgZmnsx++5
        pYOT4z2YJpFgm91B6SsnXxxpdiBBaVk=
Date:   Mon, 26 Aug 2019 15:45:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        konrad.wilk@oracle.com, patrick.colp@oracle.com,
        kanth.ghatraju@oracle.com, Jon.Grimm@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH 2/2] x86/microcode/intel: Issue the revision updated
 message only on the BSP
Message-ID: <20190826134554.GF27636@zn.tnic>
References: <1566506627-16536-1-git-send-email-mihai.carabas@oracle.com>
 <1566506627-16536-2-git-send-email-mihai.carabas@oracle.com>
 <20190824085156.GA16813@zn.tnic>
 <20190824085341.GC16813@zn.tnic>
 <d737fed1-541b-d0ba-c5cb-629da114d22a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d737fed1-541b-d0ba-c5cb-629da114d22a@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:34:01AM -0400, Boris Ostrovsky wrote:
> AMD too?

We're not doing this output shortening on AMD at all. As before,
non-ugly patches are welcome. :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
