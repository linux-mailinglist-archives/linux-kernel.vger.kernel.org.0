Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91A352154C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2019 10:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbfEQIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 May 2019 04:23:34 -0400
Received: from verein.lst.de ([213.95.11.211]:36119 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbfEQIXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:23:34 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D286D68B02; Fri, 17 May 2019 10:23:12 +0200 (CEST)
Date:   Fri, 17 May 2019 10:23:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     stummala@codeaurora.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
Message-ID: <20190517082312.GA13457@lst.de>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org> <20190131032011.GC7308@codeaurora.org> <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 06:27:53PM +0530, stummala@codeaurora.org wrote:
> Hi Christoph, Al,
>
> Can you please consider this patch for merging?

I've been sitting on this for a while, mostly because I can't convince
myself it is safe.  What protects other threads from using ->s_dentry
just when we clear it?  Also why would sd->s_dentry == dentry ever be
false?
