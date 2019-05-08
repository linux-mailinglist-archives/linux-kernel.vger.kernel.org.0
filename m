Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 520161812A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2019 22:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfEHUkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 May 2019 16:40:42 -0400
Received: from ms.lwn.net ([45.79.88.28]:54898 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfEHUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 16:40:41 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3D0187DC;
        Wed,  8 May 2019 20:40:41 +0000 (UTC)
Date:   Wed, 8 May 2019 14:40:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/27] Include linux x86 docs into Sphinx TOC tree
Message-ID: <20190508144040.442bfad2@lwn.net>
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 May 2019 23:21:14 +0800
Changbin Du <changbin.du@gmail.com> wrote:

> The kernel now uses Sphinx to generate intelligent and beautiful documentation
> from reStructuredText files. I converted all of the Linux x86 docs to rst
> format in this serias.
> 
> For you to preview, please visit below url:
> http://www.bytemem.com:8080/kernel-doc/index.html
> 
> Thank you!

Eventually we'll want to think about whether this should be a top-level
directory, but that can be for another day.  I have applied this series,
many thanks.

jon
