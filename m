Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1B17EBA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2019 06:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfHBEtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Aug 2019 00:49:25 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:18620 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731794AbfHBEtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:49:25 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id x724n8WX012844;
        Fri, 2 Aug 2019 06:49:08 +0200
Date:   Fri, 2 Aug 2019 06:49:08 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190802044908.GA12834@1wt.eu>
References: <20190725130113.GA12932@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725130113.GA12932@kroah.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Thomas,

On Thu, Jul 25, 2019 at 03:01:13PM +0200, Greg Kroah-Hartman wrote:
> +The list is encrypted and email to the list can be sent by either PGP or
> +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> +certificate. The list's PGP key and S/MIME certificate are available from
> +https://www.kernel.org/....

Just thinking, wouldn't it be useful to strongly encourage that the
document should be in plain text format ? Otherwise the door remains open
for sending you a self-extractable EXE file which contains an encrypted
Word doc, which is not the most useful to handle especially to copy-paste
mitigation code nor to comment on. Even some occasional PDFs we've seen
on the sec@k.o list were sometimes quite detailed but less convenient
than the vast majority of plain text ones, particularly when it comes
to quoting some parts.

Just my two cents,
Willy
