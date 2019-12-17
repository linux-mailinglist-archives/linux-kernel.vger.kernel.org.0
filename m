Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA8CF123077
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2019 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfLQPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Dec 2019 10:36:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbfLQPg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:58 -0500
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E6D24650;
        Tue, 17 Dec 2019 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576597018;
        bh=9jZda11QUDAhqz9398m+GSMQFxNT4iopEeMhtjrMgyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NH41AYB9/8GFEVCPKVDhcG2wQUXtFJ1TNKXDwSST/RWAfiHZcrYnqXljgFuylj11X
         kOvMVkov690wSAdpRfV7l/Ep66t7Q8pyDzEXeJD8cI0ThsIffzs4qT7JbZGbvJU246
         j12ugDJcKd4dH2cKnV0TDET6JeFzKy1Rh6FsAQic=
Date:   Tue, 17 Dec 2019 17:36:52 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/2] sh: get rid of __ARCH_USE_5LEVEL_HACK
Message-ID: <20191217153651.GB4094@rapoport-lnx>
References: <20191217142150.10392-1-rppt@kernel.org>
 <20191217151549.GH1666@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217151549.GH1666@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 10:15:49AM -0500, Rich Felker wrote:
> On Tue, Dec 17, 2019 at 04:21:48PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Hi,
> > 
> > These patches update the SuperH page table folding/unfolding to take into
> > account the 5th level.
> 
> Is this only for 64-bit/sh5? If so, I'd really like to avoid having
> patch churn that nominally keeps it working, since it doesn't; GCC
> dropped support a long time ago and it was experimental to begin with,
> never appeared in production. Has anyone looked lately at what it
> would take to remove it?

This is a part of a generic cleanup of page table manipulations and removal
of __ARCH_USE_5LEVEL_HACK and the related code from the kernel. So this is
not related to a particular sh variant.
 
> Rich

-- 
Sincerely yours,
Mike.
