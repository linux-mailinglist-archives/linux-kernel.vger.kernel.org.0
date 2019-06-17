Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0DE47A31
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2019 08:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFQGrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jun 2019 02:47:14 -0400
Received: from verein.lst.de ([213.95.11.211]:32878 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfFQGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 02:47:13 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 40DAB68AA6; Mon, 17 Jun 2019 08:46:44 +0200 (CEST)
Date:   Mon, 17 Jun 2019 08:46:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: remove dead powernv code v2
Message-ID: <20190617064644.GA5435@lst.de>
References: <20190523074924.19659-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523074924.19659-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?

On Thu, May 23, 2019 at 09:49:20AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the powerpc powernv port has a fairly large chunk of code that never
> had any upstream user.  We generally strive to not keep dead code
> around, and this was affirmed at least years Maintainer summit.
> 
> Changes since v1:
>  - rebased to v5.2-rc1
>  - remove even more dead code
---end quoted text---
