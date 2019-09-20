Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E053B8F32
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2019 13:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438212AbfITLpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Sep 2019 07:45:44 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:34146 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbfITLpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:45:44 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iBHK4-00043M-D1; Fri, 20 Sep 2019 11:43:36 +0000
Date:   Fri, 20 Sep 2019 12:43:36 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     dwmw2@infradead.org, dilinger@queued.net, richard@nod.at,
        houtao1@huawei.com, bbrezillon@kernel.org, daniel.santos@pobox.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jffs2:freely allocate memory when parameters are invalid
Message-ID: <20190920114336.GM1131@ZenIV.linux.org.uk>
References: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568962478-126260-1-git-send-email-nixiaoming@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:54:38PM +0800, Xiaoming Ni wrote:
> Use kzalloc() to allocate memory in jffs2_fill_super().
> Freeing memory when jffs2_parse_options() fails will cause
> use-after-free and double-free in jffs2_kill_sb()

... so we are not freeing it there.  What's the problem?
