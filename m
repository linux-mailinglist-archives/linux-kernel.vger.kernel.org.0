Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14B9A16F28B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2020 23:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgBYWW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Feb 2020 17:22:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46954 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:22:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so388990pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i3qcrHEDwkcSU2z2ysXEkHeEf2Lb53ngVdO/ycr/1iw=;
        b=jGMAVqCONYvFzTx1D9TK5w7TgtAGPN9yp2GVcdSWmKdRB6WBHsZ0jm4Yq0PgtKM77z
         j3JuisJmAOdHUnCWonHm2DYZd7gpEGUjX2jgwcaEtGZV6AXcEqLGsTyRTJluHcBUqVJk
         OKclfAg1Yzd0p7yiH3BAsmZg6RYEa/X6xwl9SFiPdx3RFdQ/u8vu8Yg7cuk1ar+X9fg4
         JQA7B5vOYLrXRLSAAvAX5XnwcJBInXCKV+MMa9OV/0avfqmBvsetBAKtO/EKB++TV0AV
         tggevLe8XSubFFiPegHVyj2pQNoVPpIq2BeLuvp1f7hXRAqpPu16E3ofTO2e9NRKmRU6
         Hs5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i3qcrHEDwkcSU2z2ysXEkHeEf2Lb53ngVdO/ycr/1iw=;
        b=XcGWMbcnD6Hf2Qw4MBWGflDUG41UKgLoV7+A+BFn34xwNLliWI9JBYOz1bIhWKkOBL
         YvDAJHbzkthSoyF2cJJSZtv7x9iS6rNSIUUrbcWM6Q+MjaWpKu3TnKau3qMKOrs8AfnH
         b5M9mVK1pNpDn+NbBrrVc8FvDlvxQf4CoUDA0c0Ly7t8jrfUksDET6KT3MUbtl54z2ob
         7vXcAaepcNG2tncD0TXqjpk5D8WAfLiSP0gncT+GWTJtB3W9+n2e4qrr9nenjmZWcVtz
         knbj+JXbMVrHi35WjXpWGE785oxLSuxF65GYeOSCYs94Lxos3zXZuOzdbByePpOD3CM+
         /Oxg==
X-Gm-Message-State: APjAAAXOH4cnZ8EYf23q9AQCiUnHAAUG/uuQkX0Yu6UCtu0zRV3JsfXD
        kX2Gv9xEQGMVggaXR/utwbFCPAIepyCwLg==
X-Google-Smtp-Source: APXvYqzKZ2nCPNc6QhH+oYtX1+GECkoYH1BNFvKPVMrr2AKU7Y8IUtjNjycV00baRprC58yDCr019A==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr744060plz.35.1582669345652;
        Tue, 25 Feb 2020 14:22:25 -0800 (PST)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id d4sm114311pjz.12.2020.02.25.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 14:22:25 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:22:21 -0800
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Heidi Fahim <heidifahim@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH 1/2] kunit: kunit_parser: making parser more robust
Message-ID: <20200225222221.GA144971@google.com>
References: <20200225201130.211124-1-heidifahim@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225201130.211124-1-heidifahim@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:11:29PM -0800, 'Heidi Fahim' via KUnit Development wrote:

nit: On the subject, please use the imperative. Instead of

> kunit: kunit_parser: making parser more robust

it should be

> kunit: kunit_parser: make parser more robust

> Previously, kunit_parser did not properly handle kunit TAP output that
> - had any prefixes (generated from different configs)

Specify example config that breaks kunit_parser.

> - had unrelated kernel output mixed in the middle of it, which has
> shown up when testing with allyesconfig
> To remove prefixes, the parser looks for the first line that includes
> TAP output, "TAP version 14".  It then determines the length of the
> string before this sequence, and strips that number of characters off
> the beginning of the following lines until the last KUnit output line is
> reached.
> These fixes have been tested with additional tests in the
> KUnitParseTest and their associated logs have also been added.
> 
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

A couple of minor nits, and questions below.

> ---
>  tools/testing/kunit/kunit_parser.py           | 54 +++++++--------
>  tools/testing/kunit/kunit_tool_test.py        | 69 +++++++++++++++++++
>  .../test_data/test_config_printk_time.log     | 31 +++++++++
>  .../test_data/test_interrupted_tap_output.log | 37 ++++++++++
>  .../test_data/test_kernel_panic_interrupt.log | 25 +++++++
>  .../test_data/test_multiple_prefixes.log      | 31 +++++++++
>  ..._output_with_prefix_isolated_correctly.log | 33 +++++++++
>  .../kunit/test_data/test_pound_no_prefix.log  | 33 +++++++++
>  .../kunit/test_data/test_pound_sign.log       | 33 +++++++++
>  9 files changed, 319 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/kunit/test_data/test_config_printk_time.log
>  create mode 100644 tools/testing/kunit/test_data/test_interrupted_tap_output.log
>  create mode 100644 tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
>  create mode 100644 tools/testing/kunit/test_data/test_multiple_prefixes.log
>  create mode 100644 tools/testing/kunit/test_data/test_output_with_prefix_isolated_correctly.log
>  create mode 100644 tools/testing/kunit/test_data/test_pound_no_prefix.log
>  create mode 100644 tools/testing/kunit/test_data/test_pound_sign.log
> 
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 4ffbae0f6732..077b21d42258 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -46,19 +46,21 @@ class TestStatus(Enum):
>  	TEST_CRASHED = auto()
>  	NO_TESTS = auto()
>  
> -kunit_start_re = re.compile(r'^TAP version [0-9]+$')
> -kunit_end_re = re.compile('List of all partitions:')
> +kunit_start_re = re.compile(r'TAP version [0-9]+$')
> +kunit_end_re = re.compile('(List of all partitions:|'
> +			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
>  
>  def isolate_kunit_output(kernel_output):
>  	started = False
>  	for line in kernel_output:
> -		if kunit_start_re.match(line):
> +		if kunit_start_re.search(line):
> +			prefix_len = len(line.split('TAP version')[0])
>  			started = True
> -			yield line
> -		elif kunit_end_re.match(line):
> +			yield line[prefix_len:] if prefix_len > 0 else line
> +		elif kunit_end_re.search(line):
>  			break
>  		elif started:
> -			yield line
> +			yield line[prefix_len:] if prefix_len > 0 else line
>  
>  def raw_output(kernel_output):
>  	for line in kernel_output:
> @@ -91,35 +93,33 @@ def print_log(log):
>  	for m in log:
>  		print_with_timestamp(m)
>  
> -TAP_ENTRIES = re.compile(r'^(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t?#).*$')
> +TAP_ENTRIES = re.compile(r'(TAP|\t?ok|\t?not ok|\t?[0-9]+\.\.[0-9]+|\t# .*?:.*?).*$')

Since you now strip off prefixes using length, does the old TAP regex no
longer work?

>  def consume_non_diagnositic(lines: List[str]) -> None:
> -	while lines and not TAP_ENTRIES.match(lines[0]):
> +	while lines and not TAP_ENTRIES.search(lines[0]):
>  		lines.pop(0)
>  
>  def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
> -	while lines and not TAP_ENTRIES.match(lines[0]):
> +	while lines and not TAP_ENTRIES.search(lines[0]):
>  		test_case.log.append(lines[0])
>  		lines.pop(0)
>  
>  OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
>  
> -OK_NOT_OK_SUBTEST = re.compile(r'^\t(ok|not ok) [0-9]+ - (.*)$')
> +OK_NOT_OK_SUBTEST = re.compile(r'\t(ok|not ok) [0-9]+ - (.*)$')
>  
> -OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) [0-9]+ - (.*)$')
> +OK_NOT_OK_MODULE = re.compile(r'(ok|not ok) [0-9]+ - (.*)$')

Same here.

> -def parse_ok_not_ok_test_case(lines: List[str],
> -			      test_case: TestCase,
> -			      expecting_test_case: bool) -> bool:
> +def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
>  	save_non_diagnositic(lines, test_case)
>  	if not lines:
> -		if expecting_test_case:
> -			test_case.status = TestStatus.TEST_CRASHED
> -			return True
> -		else:
> -			return False
> +		test_case.status = TestStatus.TEST_CRASHED
> +		return True
>  	line = lines[0]
>  	match = OK_NOT_OK_SUBTEST.match(line)
> +	while not match and lines:
> +		line = lines.pop(0)
> +		match = OK_NOT_OK_SUBTEST.match(line)
>  	if match:
>  		test_case.log.append(lines.pop(0))
>  		test_case.name = match.group(2)
> @@ -150,12 +150,12 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
>  	else:
>  		return False
>  
> -def parse_test_case(lines: List[str], expecting_test_case: bool) -> TestCase:
> +def parse_test_case(lines: List[str]) -> TestCase:
>  	test_case = TestCase()
>  	save_non_diagnositic(lines, test_case)
>  	while parse_diagnostic(lines, test_case):
>  		pass
> -	if parse_ok_not_ok_test_case(lines, test_case, expecting_test_case):
> +	if parse_ok_not_ok_test_case(lines, test_case):
>  		return test_case
>  	else:
>  		return None
> @@ -202,7 +202,7 @@ def parse_ok_not_ok_test_suite(lines: List[str], test_suite: TestSuite) -> bool:
>  		test_suite.status = TestStatus.TEST_CRASHED
>  		return False
>  	line = lines[0]
> -	match = OK_NOT_OK_MODULE.match(line)
> +	match = OK_NOT_OK_MODULE.search(line)
>  	if match:
>  		lines.pop(0)
>  		if match.group(1) == 'ok':
> @@ -234,11 +234,11 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
>  	expected_test_case_num = parse_subtest_plan(lines)
>  	if not expected_test_case_num:
>  		return None
> -	test_case = parse_test_case(lines, expected_test_case_num > 0)
> -	expected_test_case_num -= 1
> -	while test_case:
> +	while expected_test_case_num > 0:
> +		test_case = parse_test_case(lines)
> +		if not test_case:
> +			break
>  		test_suite.cases.append(test_case)
> -		test_case = parse_test_case(lines, expected_test_case_num > 0)
>  		expected_test_case_num -= 1

Do we use this variable anymore?

>  	if parse_ok_not_ok_test_suite(lines, test_suite):
>  		test_suite.status = bubble_up_test_case_errors(test_suite)
> @@ -250,7 +250,7 @@ def parse_test_suite(lines: List[str]) -> TestSuite:
>  		print('failed to parse end of suite' + lines[0])
>  		return None
>  
> -TAP_HEADER = re.compile(r'^TAP version 14$')
> +TAP_HEADER = re.compile(r'TAP version 14$')
>  
>  def parse_tap_header(lines: List[str]) -> bool:
>  	consume_non_diagnositic(lines)

Cheers
