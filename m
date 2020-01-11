Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD4138120
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jan 2020 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgAKLcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jan 2020 06:32:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729600AbgAKLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 06:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578742324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9JIMBpzykMbGN0PuzYKFE4Hdd5GOclhmtbykLJmrSs=;
        b=JGK80v3B2p5OPFmH3jq+YwrZRFTsrYcHg1G/5QhAwtsEwL9+EU8L5wlT0dFLkRVqILWson
        p6Ih2LEcf1yN7jWzeFA9ZgNhNVEzlsrl6L3e13jKRUVCthW2d6xzUor8pNYvhMXisptA8N
        8A/akAvKBx1Q4RQxKEh7iOFbZcXeIR0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-smPJw9mMOtSunfKzdwulRg-1; Sat, 11 Jan 2020 06:32:02 -0500
X-MC-Unique: smPJw9mMOtSunfKzdwulRg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so2228414wrm.18
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 03:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D9JIMBpzykMbGN0PuzYKFE4Hdd5GOclhmtbykLJmrSs=;
        b=i8GqxM1nyjgkGJE25fgW3U9nPe8ZZMVGIbUIfy1YaPcLLQPON+vP1NXK99S7EszEhY
         i2fxd2AQ3+hpkXTEJkQHmXv8vgqm7U7pYiU6b4TMiN2QpXcjc0oDiE2Hfl90VDTyVgp7
         5xH6uqCyFHwW+nSGEc3pkQOfXf7Z7Yoiy+OltyWfcgM3D5kBfgTpDLfh/qVIllFHePME
         umUJJx07DgVgIa5bGE6Gsnjg0x4D8et8BGGc1rOVZ6yvgEJAEA9S85fZAJqEgt9usGSS
         OkyQlU6vaxlH1jgblNsWpcSUYNm9iVyo9CyOJB76ZWqblhpXYJbPMfM8JPNbOoJ8LPOB
         N/SQ==
X-Gm-Message-State: APjAAAUn38lgY8Q8Age6ul8DbNdiqH6qtqtqCpdSYnHxJFC2+f3dsFfT
        6IV8tnCAL/svJAj1yXVgmMOHXulMd7NVi2dsx8Swp/IO/xIjHxct3bBab3ObHVVIQhzF4gw7AK3
        6O/9AEfxmSzdC6Q+Pco+Mp6yM
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr9103117wmp.109.1578742321317;
        Sat, 11 Jan 2020 03:32:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqwTB6ueVlV4g+TgfCHSZSvhFvEG7JF0PtXvFrZYJfBeGz7gM2JkRl361wMaio4LIfIp6QJ62A==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr9103104wmp.109.1578742321127;
        Sat, 11 Jan 2020 03:32:01 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bc4e:7fe8:2916:6a59? ([2001:b07:6468:f312:bc4e:7fe8:2916:6a59])
        by smtp.gmail.com with ESMTPSA id g9sm6149277wro.67.2020.01.11.03.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 03:32:00 -0800 (PST)
Subject: Re: [PATCH] KVM: remove unused guest_enter/exit
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c84ec6d3-4f5a-a24e-d907-8e5bc2729dbe@redhat.com>
Date:   Sat, 11 Jan 2020 12:32:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1578626036-118506-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/20 04:13, Alex Shi wrote:
> After commit 6edaa5307f3f ("KVM: remove kvm_guest_enter/exit wrappers")
> no one uses guest_enter/exit anymore.
> 
> So better to remove them to simplify code and reduced a bit of object
> size.

There is no reduction in object size, since these are inlines.  But PPC
still uses them.

Paolo

