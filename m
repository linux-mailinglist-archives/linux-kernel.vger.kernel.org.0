Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CB4D3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2019 18:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfFTQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jun 2019 12:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731773AbfFTQZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:25:57 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F38C2083B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561047956;
        bh=PCpDV1BAS+nhfpZqLem8qrKQsmQ6nsy+XUXdnvXiyP4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MM0kF00TTOh83EPccRjvLwWw3xyvGXlEUxSWyDc6N1GWdc1sQU3ZTMlYLpo8VGzYP
         5GTcBBQhqLfYdCOb/7tRxCdVaWoWxeEglrXFWFlxP4fY47VJwQmO0+GlNrTui0r+oK
         LEmWgnSZz96JvyIn/smhYBMA8JY4URojW4EPCCCI=
Received: by mail-wm1-f52.google.com with SMTP id u8so3787988wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 09:25:56 -0700 (PDT)
X-Gm-Message-State: APjAAAXqH7OImOkNpw/dx0L+zNa9bGUbLoQmS1cujj+f1YjCDVOvuzsR
        8mwQAHTCFz9XkzxSJULbha6dm35xekBqNA+z0LmaVQ==
X-Google-Smtp-Source: APXvYqyszLXpZAJYGEasv1Es42KJUqGOWfHcCQ48/TknNMI47klqrV7PtMy5NqM7k+CHHGizKlLym+nReaBHAEeXoVA=
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr295320wmj.79.1561047955147;
 Thu, 20 Jun 2019 09:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1560994438-235698-1-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Jun 2019 09:25:44 -0700
X-Gmail-Original-Message-ID: <CALCETrVcnccgOtxzEYqjES3qXKMVofmFfOdcY8y3s4knbw7eow@mail.gmail.com>
Message-ID: <CALCETrVcnccgOtxzEYqjES3qXKMVofmFfOdcY8y3s4knbw7eow@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] x86/umwait: Enable user wait instructions
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 6:43 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
> The sysfs interface files are in /sys/devices/system/cpu/umwait_control/

This might be a silly question, but: what do we envision as the use
case for changing the C0.2 setting?  I'm wondering if we'll ever end
up wanting it as a prctl() instead of a sysfs file.
