Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671C4FFFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 08:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfKRHij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Nov 2019 02:38:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfKRHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 02:38:38 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iWbcK-0004he-QN; Mon, 18 Nov 2019 07:38:36 +0000
Date:   Mon, 18 Nov 2019 08:38:36 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Adrian Reber <areber@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/clone3: check that all pids are released
 on error paths
Message-ID: <20191118073835.7cixac7vj2oukmao@wittgenstein>
References: <20191118064750.408003-1-avagin@gmail.com>
 <20191118064750.408003-3-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191118064750.408003-3-avagin@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 10:47:50PM -0800, Andrei Vagin wrote:
> This is a regression test case for an issue when pids have not been
> released on error paths.
> 
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Good idea. Thanks, Andrei! Applied.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
