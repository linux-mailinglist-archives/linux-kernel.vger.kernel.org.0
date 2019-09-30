Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F95BC2916
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 23:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfI3Vqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 17:46:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:35273 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731898AbfI3Vqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:46:45 -0400
Received: from webmail.gandi.net (webmail21.sd4.0x35.net [10.200.201.21])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay10.mail.gandi.net (Postfix) with ESMTPA id 78A55240003;
        Mon, 30 Sep 2019 21:46:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Oct 2019 00:46:40 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux@roeck-us.net, clang-built-linux@googlegroups.com,
        jdelvare@suse.com,
        =?UTF-8?Q?Tomasz_Pawe=C5=82_Gajc?= <tpgxyz@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon-owner@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (applesmc) fix UB and udelay overflow
In-Reply-To: <20190924174728.201464-1-ndesaulniers@google.com>
References: <CAKwvOd=GVdHhsdHOMpuhEKkWMssW37keqX5c59+6fiEgLs+Q1g@mail.gmail.com>
 <20190924174728.201464-1-ndesaulniers@google.com>
Message-ID: <e37463661a4568332bb9625eb777c5d9@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I spent quite some time to rewrite applesmc but I couldn't finish.

Thanks for the loop fix. I did my reviewing part, if that matters.

> Reported-by: Tomasz Paweł Gajc <tpgxyz@gmail.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/678
> Debugged-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Build-tested-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
