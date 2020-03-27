Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89DF6194E03
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 01:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0Aaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Mar 2020 20:30:30 -0400
Received: from namei.org ([65.99.196.166]:43868 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgC0Aaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 20:30:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 02R0Tw68018115;
        Fri, 27 Mar 2020 00:29:58 GMT
Date:   Fri, 27 Mar 2020 11:29:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     KP Singh <kpsingh@chromium.org>
cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v7 5/8] bpf: lsm: Initialize the BPF LSM hooks
In-Reply-To: <20200326142823.26277-6-kpsingh@chromium.org>
Message-ID: <alpine.LRH.2.21.2003271129430.17915@namei.org>
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-6-kpsingh@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020, KP Singh wrote:

> From: KP Singh <kpsingh@google.com>
> 
> * The hooks are initialized using the definitions in
>   include/linux/lsm_hook_defs.h.
> * The LSM can be enabled / disabled with CONFIG_BPF_LSM.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>  security/Kconfig      | 10 +++++-----
>  security/Makefile     |  2 ++
>  security/bpf/Makefile |  5 +++++
>  security/bpf/hooks.c  | 26 ++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 5 deletions(-)
>  create mode 100644 security/bpf/Makefile
>  create mode 100644 security/bpf/hooks.c


Acked-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

