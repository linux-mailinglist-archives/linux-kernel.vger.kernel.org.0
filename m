Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF1C2711
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2019 22:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfI3Upn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Sep 2019 16:45:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfI3Upn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 16:45:43 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iF2CW-0008M5-Hl; Mon, 30 Sep 2019 20:23:20 +0000
Date:   Mon, 30 Sep 2019 22:23:19 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martijn Coenen <maco@android.com>,
        Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH] binder: Fix comment headers on
 binder_alloc_prepare_to_free()
Message-ID: <20190930202319.vy424fbi4szkvysd@wittgenstein>
References: <20190930201250.139554-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190930201250.139554-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 04:12:50PM -0400, Joel Fernandes wrote:
> binder_alloc_buffer_lookup() doesn't exist and is named
> "binder_alloc_prepare_to_free()". Correct the code comments to reflect
> this.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
