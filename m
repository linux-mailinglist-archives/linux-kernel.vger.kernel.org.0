Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAAB195747
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Mar 2020 13:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0MlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Mar 2020 08:41:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36628 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgC0MlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:41:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so12188291wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HnVDDDsqTX8MxfeqmFfp9Tn3o5KLZ/pppfNiIQGaWUU=;
        b=A8KkiHIxW5mfnjqo0cLZcZh8IfHn7HLznrdYV7aPqFFm15SFa0UTabygnJhHemRtBH
         s7dZz7uQCAPVqinpRuTEDU1qFyzXTRK/c9ia70ebmPLz2klt3qGR7SxPqroVkxADCJ4k
         VEnM1FoM+w6QnEqnBfT5qMalW89SrTK1R6AuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HnVDDDsqTX8MxfeqmFfp9Tn3o5KLZ/pppfNiIQGaWUU=;
        b=Sdb8/cJ8AvVmO9+3nB8mQK1mZpcnrQdfPvdY9k55jBqtCCcaITlDiNImk+GouIHTrD
         pl0yUvkUrK6RjPIoHkW0sUx58//yLPMmHOYCUOZeUw8qiOeTNEnrMMxXgFStbBfaXAqm
         jBTz7GWsB4C/QsKu7GBMF3sKVaFErxd0S0ClrR9pgFNtz+pO/W7hihzVFp/qyawm3JUQ
         2uFv0cFKcE4uhbUqnBaNur6sKYUNrfeMMEVzsqIM9kfLl+nxhd4yd0B3GdOshXQL2ol+
         YifnTJ9sdOS+nFkqtBiG+2RtVruh2X+Xge+T2jltTWDm2tkk9FHZrC0X2rvwMy3+yeZC
         AQwg==
X-Gm-Message-State: ANhLgQ3J8OsVr1LDVWLBt9IsmfI13w0zX0dO7TaI+0YOHpBxmpRyGZ1B
        0+JMRaRlBS/UctGdv//CmK0XkdHUefY=
X-Google-Smtp-Source: ADFU+vvnFgmbe+QdpMxmXQZgR5mtej1ElSkahIq/1zjkyNYq4sg7qO361XxdE8+2Zp5RWVxPX5yKWQ==
X-Received: by 2002:a1c:9a8d:: with SMTP id c135mr5381550wme.183.1585312878062;
        Fri, 27 Mar 2020 05:41:18 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id u11sm8075975wrt.29.2020.03.27.05.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 05:41:17 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Fri, 27 Mar 2020 13:41:15 +0100
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v7 4/8] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200327124115.GA8318@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-5-kpsingh@chromium.org>
 <alpine.LRH.2.21.2003271119420.17089@namei.org>
 <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2241c806-65c9-68f5-f822-9a245ecf7ba0@tycho.nsa.gov>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-M�r 08:27, Stephen Smalley wrote:
> On 3/26/20 8:24 PM, James Morris wrote:
> > On Thu, 26 Mar 2020, KP Singh wrote:
> > 
> > > +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > +			const struct bpf_prog *prog)
> > > +{
> > > +	/* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > +	 */
> > > +	if (!capable(CAP_MAC_ADMIN))
> > > +		return -EPERM;
> > > +
> > 
> > Stephen, can you confirm that your concerns around this are resolved
> > (IIRC, by SELinux implementing a bpf_prog callback) ?
> 
> I guess the only residual concern I have is that CAP_MAC_ADMIN means
> something different to SELinux (ability to get/set file security contexts
> unknown to the currently loaded policy), so leaving the CAP_MAC_ADMIN check
> here (versus calling a new security hook here and checking CAP_MAC_ADMIN in
> the implementation of that hook for the modules that want that) conflates
> two very different things.  Prior to this patch, there are no users of
> CAP_MAC_ADMIN outside of individual security modules; it is only checked in
> module-specific logic within apparmor, safesetid, selinux, and smack, so the
> meaning was module-specific.

As we had discussed, We do have a security hook as well:

https://lore.kernel.org/bpf/20200324180652.GA11855@chromium.org/

The bpf_prog hook which can check for BPF_PROG_TYPE_LSM and implement
module specific logic for LSM programs. I thougt that was okay?

Kees was in favor of keeping the CAP_MAC_ADMIN check here:

https://lore.kernel.org/bpf/202003241133.16C02BE5B@keescook

If you feel strongly and Kees agrees, we can remove the CAP_MAC_ADMIN
check here, but given that we already have a security hook that meets
the requirements, we probably don't need another one.

- KP


> 
> 
> 
> 
