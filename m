Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754B0E9CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2019 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfJ3OBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Oct 2019 10:01:48 -0400
Received: from verein.lst.de ([213.95.11.211]:45652 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfJ3OBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 10:01:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3882E68B05; Wed, 30 Oct 2019 15:01:44 +0100 (CET)
Date:   Wed, 30 Oct 2019 15:01:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20191030140144.GA14098@lst.de>
References: <20191029074939.GA18999@lst.de> <20191030011954.60006-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030011954.60006-1-pliard@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:19:54AM +0900, Philippe Liard wrote:
> > What access do you need to synchronize?  If you read data into the
> > page cache the page lock provides all synchronization needed.  If
> > you just read into decrompression buffers there probably is no need
> > for synchronization at all as each buffer is only accessed by one
> > thread at a time.
> My main concern here was waiting for the BIO request to complete but
> submit_bio_wait() that you pointed out below should address that.

Note that if you are doing multiple bios for a single request using
submit_bio_wait might not be optimal.  In that case you probably want
a refcount and only complete when all of them are done, but by looking
at submit_bio_wait should get an idea how that works.  Alternatively look
at others users, e.g. __blkdev_direct_IO in fs/block_dev.c that already
support multiple bios.
