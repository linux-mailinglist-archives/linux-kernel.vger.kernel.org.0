Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A11CFFFA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKRHhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 02:37:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48256 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfKRHhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:37:51 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iWbbY-0004f3-Q7; Mon, 18 Nov 2019 07:37:48 +0000
Date:   Mon, 18 Nov 2019 08:37:48 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] selftests/clone3: flush stdout and stderr before
 clone3() and _exit()
Message-ID: <20191118073747.i2kc2vk6opmx4jei@wittgenstein>
References: <20191118064750.408003-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118064750.408003-1-avagin@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 10:47:48PM -0800, Andrei Vagin wrote:
> Buffers have to be flushed before clone3() to avoid double messages in
> the log.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Thanks, Andrei!
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
