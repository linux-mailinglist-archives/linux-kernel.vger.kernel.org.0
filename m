Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3AC2BF19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2019 08:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfE1GMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 May 2019 02:12:23 -0400
Received: from verein.lst.de ([213.95.11.211]:45013 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfE1GMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:12:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6013868AA6; Tue, 28 May 2019 08:11:59 +0200 (CEST)
Date:   Tue, 28 May 2019 08:11:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>, Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
Message-ID: <20190528061159.GA11705@lst.de>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org> <20190131032011.GC7308@codeaurora.org> <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org> <20190517082312.GA13457@lst.de> <20190523034956.GA10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523034956.GA10043@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to configfs-for-next.
