Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D51902B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2019 15:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHPNQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Aug 2019 09:16:12 -0400
Received: from verein.lst.de ([213.95.11.211]:55485 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfHPNQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 09:16:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CE1A68B05; Fri, 16 Aug 2019 15:16:07 +0200 (CEST)
Date:   Fri, 16 Aug 2019 15:16:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Marta Rybczynska <mrybczyn@kalray.eu>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Jones <sjones@kalray.eu>,
        Guillaume Missonnier <gmissonnier@kalray.eu>
Subject: Re: [PATCH v2] nvme: allow 64-bit results in passthru commands
Message-ID: <20190816131606.GA26191@lst.de>
References: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89520652.56920183.1565948841909.JavaMail.zimbra@kalray.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not replying to the earlier version, and thanks for doing
this work.

I wonder if instead of using our own structure we'd just use
a full nvme SQE for the input and CQE for that output.  Even if we
reserve a few fields that means we are ready for any newly used
field (at least until the SQE/CQE sizes are expanded..).

On Fri, Aug 16, 2019 at 11:47:21AM +0200, Marta Rybczynska wrote:
> It is not possible to get 64-bit results from the passthru commands,
> what prevents from getting for the Capabilities (CAP) property value.
> 
> As a result, it is not possible to implement IOL's NVMe Conformance
> test 4.3 Case 1 for Fabrics targets [1] (page 123).

Not that I'm not sure passing through fabrics commands is an all that
good idea.  But we have pending NVMe TPs that use 64-bit result
values as well, so this seems like a good idea in general.
