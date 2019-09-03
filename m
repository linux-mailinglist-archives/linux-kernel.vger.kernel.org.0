Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08302A6742
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 13:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfICLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 07:17:17 -0400
Received: from nautica.notk.org ([91.121.71.147]:57090 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfICLRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 07:17:17 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id B341BC01B; Tue,  3 Sep 2019 13:17:15 +0200 (CEST)
Date:   Tue, 3 Sep 2019 13:17:00 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 9p/vfs_super.c: Remove unused parameter data in
 v9fs_fill_super
Message-ID: <20190903111700.GA32644@nautica>
References: <20190523165619.GA4209@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523165619.GA4209@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Vedartham wrote on Thu, May 23, 2019:
> v9fs_fill_super has a param 'void *data' which is unused in the
> function.
> 
> This patch removes the 'void *data' param in v9fs_fill_super and changes
> the parameters in all function calls of v9fs_fill_super.
> 
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>

I just realized I had never replied to this patch - queued it today, as
well as the other you had sent around the same period.

Sorry for the delay, and thanks for sending patches - I don't
particularily care for cleanup like this one but it's always good to
take.

-- 
Dominique
