Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD21090EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2019 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfKYPSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Nov 2019 10:18:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:59690 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727785AbfKYPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:18:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5584B262;
        Mon, 25 Nov 2019 15:18:11 +0000 (UTC)
Date:   Mon, 25 Nov 2019 15:18:08 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: use the existing variable instead of a duplicate
 statement
Message-ID: <20191125151808.GK28938@suse.de>
References: <20191125145320.GA21484@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20191125145320.GA21484@haolee.github.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:53:20PM +0000, Hao Lee wrote:
> The address of zone has been stored in variable 'zone', so there is no need
> to get it again with a duplicate statement.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
