Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6971804A5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Mar 2020 18:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgCJRTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Mar 2020 13:19:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:44084 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgCJRTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:19:53 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EBC752E4;
        Tue, 10 Mar 2020 17:19:52 +0000 (UTC)
Date:   Tue, 10 Mar 2020 11:19:52 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Troup <james.troup@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: deprecated.rst: Add %p to the list
Message-ID: <20200310111952.4a6ad4f0@lwn.net>
In-Reply-To: <202003042301.F844A8C0EC@keescook>
References: <202003042301.F844A8C0EC@keescook>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 23:03:47 -0800
Kees Cook <keescook@chromium.org> wrote:

> Once in a while %p usage comes up, and I've needed to have a reference
> to point people to. Add %p details to deprecated.rst.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: rewrite much of the text to be more clear (James Troup)

Applied, thanks.

jon
