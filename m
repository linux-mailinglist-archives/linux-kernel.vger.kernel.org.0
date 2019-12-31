Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F042212D95D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Dec 2019 15:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaOFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Dec 2019 09:05:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50430 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfLaOFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 09:05:01 -0500
Received: from [172.58.107.126] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1imI8n-0007rW-Nb; Tue, 31 Dec 2019 14:04:58 +0000
Date:   Tue, 31 Dec 2019 15:04:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <20191231140451.rcz7lsv7f2npuzuj@wittgenstein>
References: <20191230203811.4996-1-sargun@sargun.me>
 <201912301402.DAA6ED9A0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201912301402.DAA6ED9A0@keescook>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 02:02:45PM -0800, Kees Cook wrote:
> On Mon, Dec 30, 2019 at 12:38:11PM -0800, Sargun Dhillon wrote:
> > This adds to the user_notification_basic to set a field of seccomp_notif
> > to an invalid value to ensure that the kernel returns EINVAL if any of the
> > seccomp_notif fields are set to invalid values.
> > 
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
> > Cc: Kees Cook <keescook@chromium.org>
> 
> Thanks! Applied. :)

Thanks everyone and guten Rutsch
( https://en.wiktionary.org/wiki/guten_Rutsch )
:)

Christian
