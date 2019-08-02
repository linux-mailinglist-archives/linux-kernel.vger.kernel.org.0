Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8807800B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 21:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391964AbfHBTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 15:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35484 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:14:36 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 973AE174C;
        Fri,  2 Aug 2019 19:14:34 +0000 (UTC)
Date:   Fri, 2 Aug 2019 12:14:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memremap: move from kernel/ to mm/
Message-Id: <20190802121431.3ef9d271c40703b4145d364e@linux-foundation.org>
In-Reply-To: <20190802083230.GB11000@lst.de>
References: <20190722094143.18387-1-hch@lst.de>
        <20190802083230.GB11000@lst.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 10:32:30 +0200 Christoph Hellwig <hch@lst.de> wrote:

> Andrew,
> 
> I've seen you've queued this up in -mm, but the explicit intent here was
> to quickly merge this after -rc1 so that the move doesn't conflict with
> further development for 5.3.

Didn't know that.

>  Any chance you could send this patch on to Linus?

Sure, I'll add it to today's batch.
