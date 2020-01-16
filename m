Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A292B13FA02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbgAPTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 14:52:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:44572 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730082AbgAPTwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:52:01 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A771E2CA;
        Thu, 16 Jan 2020 19:52:00 +0000 (UTC)
Date:   Thu, 16 Jan 2020 12:51:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     mchehab+samsung@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 0/9] Documentation: nfs: Convert a few documents to
 RST and move them to admin-guide
Message-ID: <20200116125159.5e1cb227@lwn.net>
In-Reply-To: <cover.1578697871.git.dwlsalmeida@gmail.com>
References: <cover.1578697871.git.dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 20:24:22 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> This series converts a few docs in Documentation/filesystems/nfs to RST.
> The docs were also moved into admin-guide because they contain information
> that might be useful for system administrators
> 
> Most changes are related to aesthetics and presentation, i.e. the content
> itself remains mostly untouched. The use of markup was limited in order
> not to negatively impact the plain-text reading experience.

OK, I've applied the full set to docs-next.  Many thanks for doing this
work and for your patience in getting it ready to apply!

jon
