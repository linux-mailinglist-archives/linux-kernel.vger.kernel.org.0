Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03356126744
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Dec 2019 17:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfLSQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Dec 2019 11:36:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:37162 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSQg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:36:57 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C26C52E5;
        Thu, 19 Dec 2019 16:36:56 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:36:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     madhuparnabhowmik04@gmail.com
Cc:     mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: filesystems: automount-support: Change
 reference to document autofs.txt to autofs.rst
Message-ID: <20191219093655.357cfc65@lwn.net>
In-Reply-To: <20191204101939.6939-1-madhuparnabhowmik04@gmail.com>
References: <20191204101939.6939-1-madhuparnabhowmik04@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 15:49:39 +0530
madhuparnabhowmik04@gmail.com wrote:

> From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
> 
> This patch fixes following documentation build warning:
> Warning: Documentation/filesystems/automount-support.txt references
> a file that doesn't exist: Documentation/filesystems/autofs.txt
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

Both patches (finally) applied, thanks.

jon
