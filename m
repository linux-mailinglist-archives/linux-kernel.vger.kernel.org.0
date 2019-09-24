Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F02BBFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2019 04:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408497AbfIXCDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Sep 2019 22:03:52 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbfIXCDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:03:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCaBB-0001ux-0a; Tue, 24 Sep 2019 02:03:49 +0000
Date:   Tue, 24 Sep 2019 03:03:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     John Johansen <john.johansen@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [WTF?] aafs_create_symlink() weirdness
Message-ID: <20190924020348.GD26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


static struct dentry *aafs_create_symlink(const char *name,
                                          struct dentry *parent,
                                          const char *target,
                                          void *private,
                                          const struct inode_operations *iops)
{
        struct dentry *dent;
        char *link = NULL;

        if (target) {
                if (!link)
                        return ERR_PTR(-ENOMEM);
        }

Er...  That's an odd way to spell
	if (target)
		return ERR_PTR(-ENOMEM);
(and an odd error value to use).  Especially since all callers are passing
NULL as target.

Why is that code even there, why does that argument still exist and
how many people have actually read that function?
