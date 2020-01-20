Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73542142C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jan 2020 14:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgATNkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jan 2020 08:40:22 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56834 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgATNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:40:21 -0500
Received: from localhost (82-95-191-104.ip.xs4all.nl [82.95.191.104])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4492214EAD059;
        Mon, 20 Jan 2020 05:40:20 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:40:18 +0100 (CET)
Message-Id: <20200120.144018.2001366678149022517.davem@davemloft.net>
To:     masahiroy@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide: remove unneeded header include path to drivers/ide
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200104164011.22189-1-masahiroy@kernel.org>
References: <20200104164011.22189-1-masahiroy@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Jan 2020 05:40:20 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun,  5 Jan 2020 01:40:11 +0900

> I can build drivers/ide/ without this.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied.
