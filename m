Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32758E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 01:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfF0XR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jun 2019 19:17:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41392 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF0XR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 19:17:59 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so8508953ioc.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ALt8d0AtAjsRjrBD8rKsbA1G2O0Y0X5Cg7cv209nE4=;
        b=aU9s6q0Gw5jxFhUMjcSh770eZamw7jwmsQtPSF3OsojwjJFkj/vdbzg1uaasp6O8oC
         5Lf3Iylyam/fkMhb8IeT/68P8BTYkIsHI7vQ1GPqKc88kecKDHl2WC5/8te3z2WBI0Qn
         GcvLKKGe42nXpXjVYDLUDxBy0h88aHmFLnnxMaBSeVl0DYkoN2HA9rSmkVseW8dwgwZT
         vq+yckoAVxXmA1g0SqgcQ40WeZxmKDNcr597rc7c0Hek93KVhbjPOLKlC3lbT9+wUCJ6
         2ANHgiLq+yJhPrxCs/QctQgXz782a+MotcpW5OxWyVZWuus/ZiT/xHuN/4vSOSGpSROl
         c1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ALt8d0AtAjsRjrBD8rKsbA1G2O0Y0X5Cg7cv209nE4=;
        b=cCA1Kj+mRdRKYupiPn2/qQfwnZdgS6U1k2a4ciiBSz/eQwZtV026s4XFMFX/CMRQCW
         YOMoCzZ1m8Cdhtg/4coarTYJubXOnwP4eusptYJCMvyRsBjsRP4OjvT73U3vTVeyp/Qk
         Nc88vlP5J7vqofyeqkz6I/jMb56MxMlLAqYiYlScJ20S5Vnc7ppD6mii+jMz2cbsIc0q
         guRYEICncGrCyUn69B3z+auUb6ko5u5LgGcbVlq1P9PMNm56MKvMuNwfJ6r3gajXpZiu
         Kt9YcXlzxx2dk2aPTw5ecuW2QKWm2E8hsHCTfLbqJiN8yckiPcAgxes1cOebTfmZS/GF
         DrbA==
X-Gm-Message-State: APjAAAU/BNcqFoqP+tS0qgrRNIQTGFLtO6kvFyTZNV0lHeIpK1EBIjyp
        FvxQvKYAAa2Z9i+hhOsjlhIFVu1oeBMCwHSMnkkw/w==
X-Google-Smtp-Source: APXvYqyOUB8xbkKRjPyKPBurKBA+e3hSaS/yPPQW2nJi/+xOea08zQ3i0BDwUHECu+YT1wis6SvkIp+6xGsGO0jzQ9k=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr7960681iod.46.1561677478172;
 Thu, 27 Jun 2019 16:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com> <alpine.LRH.2.21.1906271423070.16512@namei.org>
 <CACdnJusJeCYPKVFHiu6yn+mfqQe5k0RqZhbCUZEkxtXx_shMmw@mail.gmail.com> <alpine.LRH.2.21.1906280411370.18880@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906280411370.18880@namei.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 16:17:46 -0700
Message-ID: <CACdnJuvRtQWFknzxLwKc6erCBZ3+6tXmabEdRuXXGTGrYEAp6w@mail.gmail.com>
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:14 AM James Morris <jmorris@namei.org> wrote:
>
> On Thu, 27 Jun 2019, Matthew Garrett wrote:
>
> > By that metric, on a secure boot system how do we determine that code
> > running in the firmware environment wasn't compromised before it
> > launched the initial signed kernel?
>
> Remote attestation tied to a hardware root of trust, before allowing
> access to any further resources.

If you use IMA you can get the same guarantees over kexec.
