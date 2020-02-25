Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D54216BEEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 11:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgBYKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 05:37:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:53220 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgBYKhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:37:17 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D9D486D9;
        Tue, 25 Feb 2020 10:37:15 +0000 (UTC)
Date:   Tue, 25 Feb 2020 03:37:10 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: add a script to check sysctl docs
Message-ID: <20200225033710.312450f6@lwn.net>
In-Reply-To: <20200219153442.10205-1-steve@sk2.org>
References: <20200219153442.10205-1-steve@sk2.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 16:34:42 +0100
Stephen Kitt <steve@sk2.org> wrote:

> This script allows sysctl documentation to be checked against the
> kernel source code, to identify missing or obsolete entries. Running
> it against 5.5 shows for example that sysctl/kernel.rst has two
> obsolete entries and is missing 52 entries.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> Changes since v2:
> * drop UTF-8 characters
> * fix license identifier
> * fix example invocation to include path as well as table
> 
> v2 was the initial submission (in v2 of the sysctl/kernel.rst patch
> set).

This seems like a useful thing to have, so I've applied it.  It would be
rather more useful, though, with a bit of ... wait for it ...
documentation.  Even just an example command line in the header comments
would be a good place to start.  Care to send a followup? :)

Thanks,

jon
