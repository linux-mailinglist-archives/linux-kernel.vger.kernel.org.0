Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6AB11BBB5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2019 19:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfLKS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Dec 2019 13:28:08 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35030 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731155AbfLKS2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:28:08 -0500
Received: by mail-io1-f67.google.com with SMTP id v18so23762968iol.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 10:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYZ+lGswFVXkExunAAAaOydIGqZJAHmJZ1GU8MypIx8=;
        b=YgOzV4v6I/TJVJydU7kTxVhF0VMLBMt2iNdLA+J1hNO6gC79rsTSsyFWoBw6gMfalQ
         jpz8UmB5Ox1hpBkwq/d5lES/48ikNJgOpc0sq6kUr0dcFaX5KyrXM1n1CPCxuMQmEDdF
         3Z7w09S39qzud1kYHF4BXd0Lo3dWITtHys7ilImYhq601hu7LNc2r6nhX/rRIceQFEP5
         1VY4h1GZsm/4GtPXsbWOCrcfTnOZlhQ1NH/FEkDjWWcOTFWnrxu1ioaPwIVlzjS53fKh
         f3jAWpXen+JUdXQ0LDpScWpevyZbsFXNnrDfH2y+9sw+YQURKrXTJJ56cWRLir8caxGV
         y9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYZ+lGswFVXkExunAAAaOydIGqZJAHmJZ1GU8MypIx8=;
        b=Y1pMvO1FNfUwzIMTvewOkenbl+/7WHAxCyJYUhYrGd13GtIt1s1ndf4ZUWP24+wRuT
         2XGoOs0iNjrtS4SKnabGVjkNiDm+ONuWxdQBaUeC6uFJwWfp/RCyUnwPubvE0KIJeGBz
         UqgkS4kUtS7BJeGGeQg9beyVTDbbsjRSed8jFxqdxdTA+f5QCQuBkc3DxjXn+SOkWAfM
         StWF7NQEMEfS0k/6hbzvaUvMebmbr83L/jXRHWCOmdPSqzstX2GCz78TN8sITv4ZIO3Z
         NqVmdqGsO1XtGpqjP+vjJT6e8OzO5/0qKu8jFyP7OoX/ffzzRaNm3E9cOxH+3fjY/Phg
         dXYw==
X-Gm-Message-State: APjAAAWS/iBWvYnaKgEbOD+hl+3rqOU0r1loAe+6vkOnHo5kkmLeXnxn
        hScnoNAfVE1RA/lonC7B45ciBQGyqmoilXv3xiILwA==
X-Google-Smtp-Source: APXvYqxIDlpEs2zoJLhRiXAXqzWo0oO6DflPW5rIoWl9fbpISlPNO+TX2x2qqejGkIbmidkvc94EXMb/3GXV1Hu5hYQ=
X-Received: by 2002:a6b:3b49:: with SMTP id i70mr3977659ioa.108.1576088887157;
 Wed, 11 Dec 2019 10:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20191211175822.1925-1-sean.j.christopherson@intel.com> <20191211175822.1925-3-sean.j.christopherson@intel.com>
In-Reply-To: <20191211175822.1925-3-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 11 Dec 2019 10:27:56 -0800
Message-ID: <CALMp9eTqtTRgQZaCdbkEkL6bChCTOgVPgbYTjBi5iOqsTn4r-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: x86: Refactor and rename bit() to feature_bit() macro
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 9:58 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Rename bit() to __feature_bit() to give it a more descriptive name, and
> add a macro, feature_bit(), to stuff the X68_FEATURE_ prefix to keep
> line lengths manageable for code that hardcodes the bit to be retrieved.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
