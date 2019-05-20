Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC624127
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2019 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfETT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 May 2019 15:26:28 -0400
Received: from ms.lwn.net ([45.79.88.28]:35720 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbfETT02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:26:28 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 00A432DC;
        Mon, 20 May 2019 19:26:27 +0000 (UTC)
Date:   Mon, 20 May 2019 13:26:26 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] scripts/spdxcheck.py: Fix path to deprecated licenses
Message-ID: <20190520132626.2440be1c@lwn.net>
In-Reply-To: <20190511201917.20828-1-sven@narfation.org>
References: <20190511201917.20828-1-sven@narfation.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2019 22:19:16 +0200
Sven Eckelmann <sven@narfation.org> wrote:

> The directory name for other licenses was changed to "deprecated" in 
> commit 62be257e986d ("LICENSES: Rename other to deprecated"). But it was
> not changed for spdxcheck.py. As result, checkpatch failed with

Both patches applied, thanks.

jon
