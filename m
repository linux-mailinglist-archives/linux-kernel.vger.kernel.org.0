Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68088C34B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2019 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387943AbfJAMre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Oct 2019 08:47:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:36388 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJAMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:47:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 200D06A2;
        Tue,  1 Oct 2019 12:47:34 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:47:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     bhenryj0117@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs: security: fix section hyperlink
Message-ID: <20191001064733.36f65170@lwn.net>
In-Reply-To: <20190925101745.3645-1-bhenryj0117@gmail.com>
References: <20190925101745.3645-1-bhenryj0117@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019 17:17:44 +0700
bhenryj0117@gmail.com wrote:

> From: Brendan Jackman <bhenryj0117@gmail.com>
> 
> The reStructuredText syntax is wrong here; not sure how it was
> intended but we can just use the section header as an implicit
> hyperlink target, with a single "outward" underscore.
> 
> Signed-off-by: Brendan Jackman <bhenryj0117@gmail.com>

Applied, thanks.

jon
