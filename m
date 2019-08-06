Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F37837E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 19:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbfHFRaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Aug 2019 13:30:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:45096 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfHFRaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:30:00 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 40F06728;
        Tue,  6 Aug 2019 17:30:00 +0000 (UTC)
Date:   Tue, 6 Aug 2019 11:29:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Todor Tomov <todor.too@gmail.com>
Cc:     will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailmap: Add an entry for my email address
Message-ID: <20190806112959.14845da4@lwn.net>
In-Reply-To: <20190801172603.14177-1-todor.too@gmail.com>
References: <20190801172603.14177-1-todor.too@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Aug 2019 20:26:03 +0300
Todor Tomov <todor.too@gmail.com> wrote:

> My @linaro.org email address doesn't exist anymore so add a
> mailmap entry to map it to my @gmail.com address.
> 
> Signed-off-by: Todor Tomov <todor.too@gmail.com>

I've applied this, but I'm still not convinced that all of these .mailmap
entries are really needed.  As long as your name matches, git shortlog
will do the right thing regardless...

jon
