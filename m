Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF1346B17
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2019 22:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfFNUjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jun 2019 16:39:49 -0400
Received: from ms.lwn.net ([45.79.88.28]:54214 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfFNUjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:39:48 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 74F04128A;
        Fri, 14 Jun 2019 20:39:47 +0000 (UTC)
Date:   Fri, 14 Jun 2019 14:39:46 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH] sphinx.rst: Add note about code snippets embedded in
 the text
Message-ID: <20190614143946.7c6072ac@lwn.net>
In-Reply-To: <20190611200316.30054-1-andrealmeid@collabora.com>
References: <20190611200316.30054-1-andrealmeid@collabora.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 17:03:16 -0300
André Almeida <andrealmeid@collabora.com> wrote:

> There's a paragraph that explains how to create fixed width text block,
> but it doesn't explains how to create fixed width text inline, although
> this feature is really used through the documentation. Fix that adding a
> quick note about it.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>

Applied, thanks.  But I do agree with Jani that we don't want to reproduce
the RST guide here.

jon
