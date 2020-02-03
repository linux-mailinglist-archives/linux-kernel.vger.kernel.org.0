Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C647F1503AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Feb 2020 10:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBCJzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Feb 2020 04:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgBCJzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:55:47 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4655B20661;
        Mon,  3 Feb 2020 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580723405;
        bh=0oz4rNG3jjtawfvHWTDokHCv83TnzaSNGD1zVS/V4dY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcT4St4kKU2H7JjnBVMcqbcCg0FspLM1F1Nl+i7C8clTuKXUIZN8Wi/OPJJBR6p5L
         tmu5abEVTbBoSJg6u1D6Pk5xx8mSQf5NEFbQ+IiN5BtI08fhDC6QsOroWVym7hKBkR
         PsV/M6Po4uYND5Syb/1M/uy1NlmlVDr9+zZeom+M=
Date:   Mon, 3 Feb 2020 09:50:00 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH -v2 00/10] Rewrite Motorola MMU page-table layout
Message-ID: <20200203095000.GB1721@willie-the-truck>
References: <20200131124531.623136425@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131124531.623136425@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 01:45:31PM +0100, Peter Zijlstra wrote:
> In order to faciliate Will's READ_ONCE() patches:
> 
>   https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> 
> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> are tested using ARAnyM/68040.
> 
> Michael tested the previous version on his Atari Falcon/68030.
> 
> Build tested for sun3/coldfire.
> 
> Please consider!

Apart from the two written by me:

Acked-by: Will Deacon <will@kernel.org>

Cheers,

Will
