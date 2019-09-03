Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1917AA724B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2019 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfICSMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Sep 2019 14:12:16 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:55695 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbfICSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:12:15 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id E35E13A32A; Tue,  3 Sep 2019 20:12:08 +0200 (CEST)
Date:   Tue, 3 Sep 2019 20:12:08 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: cleanup braces for if/else statements
Message-ID: <20190903181208.GA8469@valentin-vidic.from.hr>
References: <20190903164732.14194-1-vvidic@valentin-vidic.from.hr>
 <20190903173249.GL1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903173249.GL1131@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 06:32:49PM +0100, Al Viro wrote:
> On Tue, Sep 03, 2019 at 06:47:32PM +0200, Valentin Vidic wrote:
> > +			} else if (uni == 0xFFFF) {
> >  				skip = TRUE;
> 
> While we are at it, could you get rid of that 'TRUE' macro?

Sure, but maybe in a separate patch since TRUE/FALSE has more
calls than just this.

-- 
Valentin
