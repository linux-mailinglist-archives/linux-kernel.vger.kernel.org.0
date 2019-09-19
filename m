Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6E6B805A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2019 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391080AbfISRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Sep 2019 13:47:09 -0400
Received: from verein.lst.de ([213.95.11.211]:43049 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391038AbfISRrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:47:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8F81468B20; Thu, 19 Sep 2019 19:47:05 +0200 (CEST)
Date:   Thu, 19 Sep 2019 19:47:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
Subject: Re: [xfs] 27d1053021: xfstests.xfs.173.fail
Message-ID: <20190919174705.GA9622@lst.de>
References: <20190919014602.GN15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919014602.GN15734@shao2-debian>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 09:46:02AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 27d10530217ee6d6a0388014fd773820ee354ce5 ("xfs: remove the unused XFS_ALLOC_USERDATA flag")

Well, this does not make a whole lot of sense, given that the patch
literally just removes an unused flag.  that being said that test has
been father flakey for me for a long time.
