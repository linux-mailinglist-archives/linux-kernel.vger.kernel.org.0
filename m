Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20E5178536
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfG2Gsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 02:48:47 -0400
Received: from verein.lst.de ([213.95.11.211]:36940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfG2Gsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:48:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 03FB168B02; Mon, 29 Jul 2019 08:48:42 +0200 (CEST)
Date:   Mon, 29 Jul 2019 08:48:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     sivanich@sgi.com, arnd@arndb.de, ira.weiny@intel.com,
        jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] sgi-gru: Remove *pte_lookup functions
Message-ID: <20190729064842.GA3853@lst.de>
References: <1564170120-11882-1-git-send-email-linux.bhar@gmail.com> <1564170120-11882-2-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564170120-11882-2-git-send-email-linux.bhar@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 01:12:00AM +0530, Bharath Vedartham wrote:
> +		ret = get_user_pages_fast(vaddr, 1, write, &page);

I think you want to pass "write ? FOLL_WRITE : 0" here, as
get_user_pages_fast takes a gup_flags argument, not a boolean
write flag.
