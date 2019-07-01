Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD5551B4E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2019 21:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730295AbfFXTSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jun 2019 15:18:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbfFXTSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:18:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so15159911wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxEW1OohvlQcLnagUdrYZ6F+TsIBwQcFUxd02nvE+RU=;
        b=nZF7W2zlo265XbVDmUW32F/aZ/dmrJn/qv/ufMVAlkQ7G2TrlSGoiJV6JG7i5WkRNN
         myB610ho4vcL4xXltP4/bhb/3bomHurKJAsfS9/sIcp4N0WQCkdWItPgN45uKFCAwlIb
         Q+HZtCD4EYL+HhNkgFJ0kzouqPVZIneLjqPMjYxcH5WbR8IOn1BiWSKF3jpA3c3X8YKg
         VYmlBt00NjmVCB71z12QU+9+1ZW9ZomzmoQ1tgVxncZB3bJhN3+R5v0UOo2JgWHUvTL1
         vxDKeEzSc/GSdp84fsOljLUkAhtj9f+SDApmZNGkgn3gTeigKk5X39cqqd5Ai70onFJ/
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lxEW1OohvlQcLnagUdrYZ6F+TsIBwQcFUxd02nvE+RU=;
        b=JUANz2kNInVLuKUwanpNGjKsByUBiHb+yzV4mzF01aTktC8t7zr4QQZKxxchJyPxwO
         be+31vvfKmMGENZNqSg0tvkNQ6kVXmHpb3szRYvo6RVwst+DVf5yXiWq36lReRqOSYug
         aINU8TwbbhuKJudcLZlWapywpb9E+rAM1tU7QnAqhSByCZimPh180GCv9b+ysLSIoSic
         kbQLN2tvfPReFJ0Fxkfy6mywzvglesGksrLyBxL9eU1n2+jor3XfPnbS8dGiEsoBHr2R
         ImEy9LVAj90EgjVsKqPv8gOFY/ZVmZqMR8N2KF5ogBFZX+Gb7x10TPugnFfMeubmdpNa
         gtTg==
X-Gm-Message-State: APjAAAU+fvVCtlDUgHJebsFfto3CGb7vThN3jAv1qpCnJ8BfChdpMWt9
        U5aocOeIzddOijvyIGkl53l42w==
X-Google-Smtp-Source: APXvYqy4h5N/FeLOcZq3C1dFJDFd9oY8xJ0xWTlvXWev+mU7fzOJSsCmLphcLGBac/kUFB96zQ1acQ==
X-Received: by 2002:adf:e301:: with SMTP id b1mr22616047wrj.304.1561403899298;
        Mon, 24 Jun 2019 12:18:19 -0700 (PDT)
Received: from [192.168.0.103] (146-241-101-27.dyn.eolo.it. [146.241.101.27])
        by smtp.gmail.com with ESMTPSA id a7sm12181604wrs.94.2019.06.24.12.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 12:18:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH BUGFIX V2] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
Date:   Mon, 24 Jun 2019 21:18:17 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
Content-Transfer-Encoding: quoted-printable
Message-Id: <D9A203CB-DDA2-4C67-A20C-A3CA7354E3FB@linaro.org>
References: <20190622204416.33871-1-paolo.valente@linaro.org>
 <aec3e7b1-c235-ddb1-62b2-4ad7a7246a35@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 24 giu 2019, alle ore 18:12, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 6/22/19 2:44 PM, Paolo Valente wrote:
>> By mistake, there is a '&' instead of a '=3D=3D' in the definition of =
the
>> macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator =
with
>> the correct one.
>=20
> A bit worrying that this wasn't caught in testing, as it would have
> resulted in _any_ queue being positive for totally seeky?
>=20

Fortunately there's a somewhat reassuring explanation.  The commit
introducing this macro prevented seeky queues from being considered
soft real-time.  And, to be more selective, it actually filtered out
only totally seeky queues, i.e., queues whose last I/O requests are
*all* random.  With this error, any seeky queue was considered totally
seeky.  This the broke (only) selectivity.

> Anyway, applied.
>=20

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

