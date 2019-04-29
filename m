Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8157AE1B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2019 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfD2L5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Apr 2019 07:57:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:36508 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbfD2L5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:57:20 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3TBv70h019030;
        Mon, 29 Apr 2019 06:57:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x3TBv6Gw019029;
        Mon, 29 Apr 2019 06:57:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 29 Apr 2019 06:57:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: remove the __kernel_io_end export
Message-ID: <20190429115706.GO8599@gate.crashing.org>
References: <20190429115241.12621-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429115241.12621-1-hch@lst.de>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 06:52:41AM -0500, Christoph Hellwig wrote:
> This export was added in this merge window, but without any actual
> user, or justification for a modular user.

Hi Christoph,

> -unsigned long __kernel_io_end;
>  EXPORT_SYMBOL(__kernel_io_end);

Does that work?  Don't you need to remove that second line, as well?


Segher
