Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F2100C14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 20:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfKRTVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 14:21:24 -0500
Received: from ms.lwn.net ([45.79.88.28]:60524 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfKRTVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:21:23 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A56389B3;
        Mon, 18 Nov 2019 19:21:22 +0000 (UTC)
Date:   Mon, 18 Nov 2019 12:21:21 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     raven@themaw.net, akpm@linux-foundation.org,
        mchehab+samsung@kernel.org, neilb@suse.com, christian@brauner.io,
        mszeredi@redhat.com, ebiggers@google.com, tobin@kernel.org,
        stefanha@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/3] docs: filesystems: convert autofs.txt to reST
Message-ID: <20191118122121.64c77fcb@lwn.net>
In-Reply-To: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
References: <20191117172436.8831-1-jaskaransingh7654321@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2019 22:54:33 +0530
Jaskaran Singh <jaskaransingh7654321@gmail.com> wrote:

> The following patch series is for converting autofs.txt to reST, and
> updating some of the content.
> 
> Changes from v1:
> ----------------
> - Split patch into multiple logical changes as per Jonathan Corbet's
>   request.
> - Few more formatting changes and fixes, as pointed out by Jonathan.
> - Add short description of master map used by autofs.
> 
>  autofs.rst |  273 ++++++++++++++++++++++++++++++++-----------------------------
>  index.rst  |    1 
>  2 files changed, 148 insertions(+), 126 deletions(-)
> 
OK, I have applied this set.  Thanks for doing this work!

jon
