Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678F2A71B8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 19:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfICRdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 13:33:02 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32900 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICRdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:33:02 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.1 #3 (Red Hat Linux))
        id 1i5Cfh-0003V8-Rg; Tue, 03 Sep 2019 17:32:49 +0000
Date:   Tue, 3 Sep 2019 18:32:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: cleanup braces for if/else statements
Message-ID: <20190903173249.GL1131@ZenIV.linux.org.uk>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> +			} else if (uni == 0xFFFF) {
>  				skip = TRUE;

While we are at it, could you get rid of that 'TRUE' macro?
Or added

#define THE_TRUTH_AND_THATS_CUTTIN_ME_OWN_THROAT true

if you want to properly emphasize it...
