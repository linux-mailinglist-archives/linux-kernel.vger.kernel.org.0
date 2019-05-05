Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2FB14202
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2019 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfEETCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 May 2019 15:02:21 -0400
Received: from ms.lwn.net ([45.79.88.28]:60644 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbfEETCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 15:02:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 770E42E6;
        Sun,  5 May 2019 19:02:20 +0000 (UTC)
Date:   Sun, 5 May 2019 13:02:19 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190505130219.29bd72f8@lwn.net>
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 May 2019 15:06:06 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux x86 docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://www.bytemem.com:8080/kernel-doc/index.html
> 
> Thank you!

So which tree was this generated against?  I was gearing up to try it
out, but it doesn't really want to apply to docs-next...

Thanks,

jon
